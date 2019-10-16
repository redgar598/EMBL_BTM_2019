import matplotlib.pyplot as plt
import numpy as np
from tqdm import tqdm


def iterate(data):
    return tqdm(data, desc='Samples processed', bar_format='{l_bar}{bar}| {n_fmt}/{total_fmt}')


def show_images(inp, mask, pred):
    f, axarr = plt.subplots(1,3)
    print(inp.shape, mask.shape, pred.shape)
    axarr[0].imshow(inp[0][0])
    axarr[1].imshow(mask[0][0])
    axarr[2].imshow(pred[0][0])
    _ = [ax.axis('off') for ax in axarr]
    plt.show()


class RandomCrop(object):
    """Crop randomly the input image and the output mask"""
    def __init__(self, crop_size):
        assert isinstance(crop_size, (int, tuple, list))
        if isinstance(crop_size, int):
            self.output_size = (crop_size, crop_size)
        else:
            assert len(crop_size) == 2
            self.crop_size = crop_size

    def __call__(self, sample):
        assert len(sample) == 2
        image, mask = sample
        w, h = image.shape[1:]
        new_w, new_h = self.output_size
        top = np.random.randint(0, h - new_h) if h - new_h > 0 else 0
        left = np.random.randint(0, w - new_w) if w - new_w > 0 else 0
        image = image[:, left: left + new_w, top: top + new_h]
        mask = mask[:, left: left + new_w, top: top + new_h]
        return image, mask
