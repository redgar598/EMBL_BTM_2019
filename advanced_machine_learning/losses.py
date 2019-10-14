import math
import torch
from torch.nn import functional as F


def focal_loss(prediction, mask, gamma):
    loss = F.binary_cross_entropy_with_logits(prediction, mask, reduce=False)
    invprobs = F.logsigmoid(-prediction * (mask * 2 - 1))
    loss = (invprobs * gamma).exp() * loss
    return loss.mean()


def dice_loss(mask, prediction):
    soft = 1.
    loss = 1 - ((2 * torch.sum(mask*prediction) + soft) / (mask.sum() + prediction.sum() + soft))
    return loss


def cos_dice_loss(mask, prediction):
    cos_dice = (torch.cos(0.5 * math.pi * dice_loss(mask, prediction))) ** 2
    return cos_dice


def get_iou(prediction, mask):
    iou = (prediction & mask).sum().float() / (prediction | mask).sum().float()
    return iou
