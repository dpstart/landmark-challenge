#!/usr/bin/python
# -*- coding: utf-8 -*-

import time
import sys
import os

import numpy as np

import keras
from keras.preprocessing.image import ImageDataGenerator
from keras.preprocessing import image
from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D
from keras.layers import Activation, Dropout, Flatten, Dense
from keras import optimizers

MODEL_DIR = './models/'
TRAIN_IMAGE_DIR = './data/'

# VALIDATION_IMAGE_DIR = "./val/"

(img_width, img_height) = (128, 128)
batch_size = 16


def print_duration(start_time, msg):
    print('[%d] %s' % (int(time.time() - start_time), msg))
    start_time = time.time()
    return start_time


def train():
    if os.path.isdir(TRAIN_IMAGE_DIR):

        train_datagen = ImageDataGenerator(rescale=1. / 255,
                shear_range=0.2, zoom_range=0.2, horizontal_flip=True)

        val_datagen = ImageDataGenerator(rescale=1. / 255)

        train_generator = \
            train_datagen.flow_from_directory(TRAIN_IMAGE_DIR,
                target_size=(img_width, img_height),
                batch_size=batch_size, class_mode='categorical')

        total_val_image_count = train_generator.samples
        print(train_generator.class_indices)
        nr_of_classes = len(train_generator.class_indices)
        print(nr_of_classes)

        input_shape = (img_width, img_height, 3)

        model = Sequential()
        model.add(Conv2D(120, (3, 3), input_shape=input_shape))
        model.add(Activation('relu'))
        model.add(MaxPooling2D(pool_size=(2, 2)))

        model.add(Conv2D(80, (3, 3)))
        model.add(Activation('relu'))
        model.add(MaxPooling2D(pool_size=(2, 2)))

        model.add(Conv2D(80, (3, 3)))
        model.add(Activation('relu'))
        model.add(MaxPooling2D(pool_size=(2, 2)))

        model.add(Flatten())
        model.add(Dense(65))
        model.add(Activation('relu'))
        model.add(Dropout(0.5))
        model.add(Dense(nr_of_classes))
        model.add(Activation('sigmoid'))

        model.compile(loss='categorical_crossentropy', optimizer='sgd',
                      metrics=['accuracy'])

        # 'steps_per_epoch: Total number of steps (batches of samples) to yield from generator before declaring one
        # epoch finished and starting the next epoch.
        # It should typically be equal to the number of unique samples of your dataset divided by the batch size.

        model.fit_generator(train_generator, epochs=1,
                            steps_per_epoch=3)
        model.save(MODEL_DIR + 'model.h5')
        img = image.load_img('./data/1/colosseo.jpg', target_size=(128, 128, 3))
        print("Prediction")
        x = image.img_to_array(img)
        X = np.expand_dims(x, axis = 0)
        print(model.predict(x))
    else:

        print('Training set not found!')


def main():
    start_time = time.time()

    train()


if __name__ == '__main__':
    main()

			