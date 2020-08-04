import matplotlib
import matplotlib.pyplot as plt
from keras.utils import to_categorical
import numpy as np
from skimage.transform import resize
import os

import warnings
warnings.filterwarnings("ignore")



def process_data(path, cats_nums, sizeA, sizeB, seg_size):

    sub_path = os.listdir(path)

    all_nums = cats_nums*10
    sub_path.sort()

    image = np.zeros((all_nums, size*size, 3))

    for i in range(all_nums):
        filename = path + sub_path[i]
        image_data = plt.imread(filename)
        image_data = image_data[:seg_sizeA, :seg_sizeB]
        image_resized = resize(image_data, 
                         (sizeA, sizeB, 3), mode='constant')
        image_norm = (image_resized - np.mean(image_resized))/(np.max(image_resized)-np.min(image_resized))
        image[i] = np.reshape(image_norm, (1, sizeA*sizeB, -1))
        #image = np.reshape(x, (48, 48, -1))
    image = image.reshape((cats_nums*10, sizeA, sizeB, -1))
    
    return image


def generate_y(cats_nums):
    
    y_train = np.repeat(np.arange(cats_nums), 10)
    y_test = np.repeat(np.arange(cats_nums), 10)

    y_train = to_categorical(y_train, cats_nums)
    y_test = to_categorical(y_test, cats_nums)
    
    return y_train, y_test


def shuff_data(x_train, y_train, x_test, y_test):
    np.random.seed(42)
    shuffle_indices = np.random.permutation(np.arange(len(y_test)))

    x_test = x_test[shuffle_indices]
    y_test = y_test[shuffle_indices]

    shuffle_indices = np.random.permutation(np.arange(len(y_train)))

    x_train = x_train[shuffle_indices]
    y_train = y_train[shuffle_indices]
    
    return x_train, y_train, x_test, y_test

