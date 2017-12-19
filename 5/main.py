import keras
import cv2
import numpy as np
from keras.datasets import mnist as mnist_keras
from keras.layers import Conv2D, Dense, Dropout, Flatten, MaxPooling2D
from keras.models import Sequential, load_model
from keras import backend as K

node_count = 1024
train_samples = 60000
test_samples = 10000
batch_size = 512
num_classes = 10
epochs = 17
epochs_cnn = 12
img_rows = 28
img_cols = 28
logistic_trained = []
nn_lambda = 2



def cnn(mnist_x_train, mnist_y_train, mnist_x_test, mnist_y_test):
    print("\nNo existing model found. Training.\n")

    if K.image_data_format() == 'channels_first':
        x_train = mnist_x_train.reshape(mnist_x_train.shape[0], 1, img_rows, img_cols)
        x_test = mnist_x_test.reshape(mnist_x_test.shape[0], 1, img_rows, img_cols)
        input_shape = (1, img_rows, img_cols)
    else:
        x_train = mnist_x_train.reshape(mnist_x_train.shape[0], img_rows, img_cols, 1)
        x_test = mnist_x_test.reshape(mnist_x_test.shape[0], img_rows, img_cols, 1)
        input_shape = (img_rows, img_cols, 1)

    x_train = x_train.astype('float32')
    x_test = x_test.astype('float32')
    x_train /= 255
    x_test /= 255
    print('\nx_train shape:', x_train.shape)
    print(x_train.shape[0], 'train samples')
    print(x_test.shape[0], 'test samples')

    y_train = keras.utils.to_categorical(mnist_y_train, num_classes)
    y_test = keras.utils.to_categorical(mnist_y_test, num_classes)


    model = Sequential()
    model.add(Conv2D(32, kernel_size=(3, 3),
                     activation='relu',
                     input_shape=input_shape))
    model.add(Conv2D(64, (3, 3), activation='relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    model.add(Dropout(0.25))
    model.add(Flatten())
    model.add(Dense(128, activation='relu'))
    model.add(Dropout(0.5))
    model.add(Dense(num_classes, activation='softmax'))

    model.compile(loss=keras.losses.categorical_crossentropy,
                  optimizer=keras.optimizers.Adadelta(),
                  metrics=['accuracy'])

    model.fit(x_train, y_train,
              batch_size=batch_size,
              epochs=epochs_cnn,
              verbose=1,
              validation_data=(x_test, y_test))
    score = model.evaluate(x_test, y_test, verbose=0)
    print('Test loss:', score[0])
    print('\nTest accuracy on MNIST for CNN is: ', score[1])

    model.save("cnn.h5")
    return model

def main():
    try:
        model = load_model('cnn.h5')
    except:
        (mnist_x_train, mnist_y_train), (mnist_x_test, mnist_y_test) = mnist_keras.load_data()
        model = cnn(mnist_x_train, mnist_y_train, mnist_x_test, mnist_y_test)

    cap = cv2.VideoCapture(0)

    while(True):
        ret, frame = cap.read()
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        x, y = gray.shape
        x_center = int(x / 2)
        y_center = int(y / 2)
        gray = gray[x_center - 100:x_center + 100, y_center - 100: y_center + 100]
        disp = gray
        gray = cv2.equalizeHist(gray)
        gray = cv2.GaussianBlur(gray, (5, 5), 0)
        gray = cv2.adaptiveThreshold(gray, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 31, 30)
        cv2.imshow('frame', disp)
        sample = cv2.resize(gray, (28, 28))
        prediction = model.predict(sample.reshape((1, 28, 28, 1)), batch_size=1, verbose=0)
        prediction = np.argmax(prediction)
        print(prediction)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()
