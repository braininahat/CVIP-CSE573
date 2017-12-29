import numpy as np
import imageio
from glob import glob
from scipy.misc import imresize
from sklearn.datasets import fetch_mldata
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.utils import check_random_state
from keras.utils import to_categorical

train_samples = 60000
test_samples = 10000
batch_size = 128
num_classes = 10
epochs = 20
epochs_cnn = 12
img_rows = 28
img_cols = 28

enc = OneHotEncoder()
mnist = fetch_mldata('MNIST original')
X = mnist.data.astype('float64')
y = mnist.target
random_state = check_random_state(0)
permutation = random_state.permutation(X.shape[0])
X = X[permutation]
y = y[permutation]
X = X.reshape((X.shape[0], -1))

X_train, X_test, y_train, y_test = train_test_split(
    X, y, train_size=train_samples, test_size=test_samples)

# print("\nLabels\n")
# print(type(y_test))
# print("\nBefore scale \n")
# print(X_test)
# print(type(X_test))
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# print("\nAfter scale\n")
# print(X_test)
# print(type(X_test))

# Turn up tolerance for faster convergence
clf = LogisticRegression(C=50. / train_samples,
                         multi_class='multinomial',
                         penalty='l1', solver='saga', tol=0.01)
clf.fit(X_train, y_train)
sparsity = np.mean(clf.coef_ == 0) * 100
score = clf.score(X_test, y_test)

# print('Best C % .4f' % clf.C_)
# print("Sparsity with L1 penalty: %.2f%%" % sparsity)
# print("Test score with L1 penalty: %.4f" % score)
img_list = glob("proj3_images/Numerals/*/*.png")
labels = [int(path.split('/')[2]) for path in img_list]

img_list = [imageio.imread(img) for img in img_list]
gray = [img[:, :, 0] for img in img_list]

resized = [
    1 - (imresize(
        img, (img_rows,
              img_cols)).flatten(order='C') / 255) for img in gray]

resized = np.array(resized)

logistic_score = clf.score(resized, labels)
print(logistic_score)
