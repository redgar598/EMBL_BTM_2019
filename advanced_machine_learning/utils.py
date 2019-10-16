import torch
import matplotlib.pyplot as plt
import numpy as np
from tqdm import tqdm


def iterate(data):
    return tqdm(data, desc='Samples processed', bar_format='{l_bar}{bar}| {n_fmt}/{total_fmt}')


def get_iou(prediction, mask):
    iou = (prediction & mask).sum().float() / (prediction | mask).sum().float()
    return iou


def show_images(inp, mask, pred):
    f, axarr = plt.subplots(1, 3)
    axarr[0].imshow(inp[0][0])
    axarr[1].imshow(mask[0][0])
    axarr[2].imshow(pred[0][0])
    _ = [ax.axis('off') for ax in axarr]
    plt.show()


def show_dataset(dataset):
    idx = np.random.randint(0, dataset.__len__())
    img, mask = dataset.__getitem__(idx)
    f, axarr = plt.subplots(1, 2)
    axarr[0].imshow(img[0])
    axarr[1].imshow(mask[0])
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


def evaluate(dataloader, model):
    print ('Evaluating!')
    dataset_size = len(dataloader)
    test_accuracy = 0.0
    test_iou = 0.0
    count = 0
    model.eval()
    with torch.no_grad():
        for images, masks in iterate(dataloader):
            count += 1
            outputs = model(images)
            predictions = (outputs > 0.5)
            accuracy = torch.mean((predictions == masks.byte()).float())
            iou = get_iou(predictions, masks.type(torch.bool))
            test_accuracy += accuracy.item()
            test_iou += iou.item()
    epoch_accuracy = test_accuracy / dataset_size
    epoch_iou = test_iou / dataset_size
    print('Evaluation iou is {:.6f}, accuracy is {:.6f}'.format(epoch_iou, epoch_accuracy))
