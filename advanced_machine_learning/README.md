# Advanced Machine Learning

In this course we will step through a Machine Learning pipeline for segmenting nuclei in microscopy images from [Kaggle Data Science Bowl competition](https://www.kaggle.com/c/data-science-bowl-2018). 

Here are some examples of the images we will be working with:

![alt text](https://github.com/redgar598/EMBL_BTM_2019/blob/master/advanced_machine_learning/imgs/pic1.png "Image 1")
![alt text](https://github.com/redgar598/EMBL_BTM_2019/blob/master/advanced_machine_learning/imgs/pic2.png "Image 2")
![alt text](https://github.com/redgar598/EMBL_BTM_2019/blob/master/advanced_machine_learning/imgs/pic3.png "Image 3")
![alt text](https://github.com/redgar598/EMBL_BTM_2019/blob/master/advanced_machine_learning/imgs/pic4.png "Image 4")

## Install and work along
- To run the examples in this workshop please follow the instructions [here](https://github.com/redgar598/EMBL_BTM_2019/tree/master/Install). If you created the BTM environment, please load it with

```
conda activate BTM
```
You are expected to have conda installed and the BTM environment activated. 

-- If this doesn't work for some reason, install [Anaconda](https://www.anaconda.com/distribution/) following the instructions on their webpage and install git with:

```
conda install -c anaconda git
```

- Once you are done with the steps above, install additional packages required for this tutorial, please, run
```
conda install -c conda-forge -c pytorch pytorch torchvision pillow scipy tqdm
```

Afterwards, please, download the nuclei data [here](https://drive.google.com/file/d/1tyI7ig2obOxAdEnKBrUXFD7uZQX9tRKD/view?usp=sharing). You would need to unzip the data in a directory you want to work in.
## Useful links
1. [Machine Learning course](https://www.coursera.org/learn/machine-learning) by Andrew Ng on Coursera
2. [Convolutional Neural Networks for Visual Recognition](http://cs231n.stanford.edu/syllabus.html) - a Stanford course
3. [PyTorch Tutorials](https://pytorch.org/tutorials/) - Getting Started Tutorials for Image and Text processing
4. [UNet](https://towardsdatascience.com/u-net-b229b32b4a71) - The Intuition Behind UNet
5. [Focal and Dice Loss](https://becominghuman.ai/investigating-focal-and-dice-loss-for-the-kaggle-2018-data-science-bowl-65fb9af4f36c) - Investigating Focal and Dice Loss for the Kaggle 2018 Data Science Bowl   
