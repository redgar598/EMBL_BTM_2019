import os
import numpy as np
from PIL import Image
from scipy.ndimage import binary_erosion
import torch
from torch.utils.data import Dataset
from torchvision import transforms


class NucleiDataset(Dataset):
    """ Nuclei and masks """
    def __init__(self, root_dir, input_transforms=None, target_transforms=None):
        self.root_dir = root_dir
        self.input_transforms = input_transforms
        self.target_transforms = target_transforms
        self.samples = os.listdir(root_dir)
        self.to_tensor = transforms.ToTensor()

    def __len__(self):
        return len(self.samples)

    def __getitem__(self, idx):
        img_name = os.path.join(self.root_dir, self.samples[idx],
                                'images', self.samples[idx]+'.png')
        image = Image.open(img_name)
        image = image.convert("RGB")
        if self.input_transforms is not None:
            image = self.input_transforms(image)
        else:
            image = self.to_tensor(image)
        masks_dir = os.path.join(self.root_dir, self.samples[idx], 'masks')
        if not os.path.isdir(masks_dir):
            return image
        masks_list = os.listdir(masks_dir)
        mask = torch.zeros(1, len(image[0]), len(image[0][0]))
        for mask_name in masks_list:
            one_nuclei_mask = Image.open(os.path.join(masks_dir, mask_name))
            one_nuclei_mask = binary_erosion(one_nuclei_mask).astype('float32')
            one_nuclei_mask = self.to_tensor(one_nuclei_mask[..., np.newaxis])
            mask += one_nuclei_mask
        if self.target_transforms is not None:
            mask = self.target_transforms(mask)
        return image, mask
