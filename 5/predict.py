import cv2
from keras.models import load_model

camera = cv2.VideoCapture(0)

ret, img = camera.read()

cv2.imshow('frame', img)

cv2.waitKey(1)

camera.release()

cv2.destroyAllWindows()

# def prediction():
#     load_model("cnn.py")
