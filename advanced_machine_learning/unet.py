import torch
import torch.nn as nn
# TODO: device


class UNetBlock(nn.Module):
    def __init__(self, in_dim, out_dim):
        super(UNetBlock, self).__init__()
        self.conv1 = nn.Conv2d(in_dim, out_dim, kernel_size=3, padding=1)
        self.norm1 = nn.BatchNorm2d(out_dim)
        self.conv2 = nn.Conv2d(out_dim, out_dim, kernel_size=3, padding=1)
        self.norm2 = nn.BatchNorm2d(out_dim)
        self.activation = nn.ReLU()

    def forward(self, x):
        x = self.conv1(x)
        x = self.activation(x)
        x = self.norm1(x)
        x = self.conv2(x)
        x = self.activation(x)
        x = self.norm2(x)
        return x


class UNetBlockDown(UNetBlock):
    def __init__(self, in_dim, out_dim):
        super(UNetBlockDown, self).__init__(in_dim, out_dim)
        self.pool = nn.MaxPool2d(2, stride=2)

    def forward(self, x):
        x = self.pool(x)
        x = super().forward(x)
        return x


class UNetBlockUp(UNetBlock):
    def __init__(self, in_dim, out_dim):
        super(UNetBlockUp, self).__init__(in_dim, out_dim)
        self.up_conv = nn.ConvTranspose2d(in_dim, out_dim, stride=2, kernel_size=2)
        self.up_norm = nn.BatchNorm2d(out_dim)

    def forward(self, x, saved_x):
        x = self.up_conv(x)
        x = self.activation(x)
        x = self.up_norm(x)
        if x.shape[2] < saved_x.shape[2]:
            padding = torch.zeros(x.shape[0], x.shape[1], 1, x.shape[3])#.to(device)
            x = torch.cat((x, padding), 2)
        if x.shape[3] < saved_x.shape[3]:
            padding = torch.zeros(x.shape[0], x.shape[1], x.shape[2], 1)#.to(device)
            x = torch.cat((x, padding), 3)
        x = torch.cat((x, saved_x), 1)
        x = super().forward(x)
        return x


class UNet(nn.Module):
    def __init__(self, in_filters, num_layers):
        super(UNet, self).__init__()
        self.first_layer = UNetBlock(1, in_filters)
        self.blocks_down = nn.ModuleList()
        for _ in range(num_layers):
            self.blocks_down.append(UNetBlockDown(in_filters, in_filters*2))
            in_filters *= 2
        self.blocks_up = nn.ModuleList()
        for _ in range(num_layers):
            self.blocks_up.append(UNetBlockUp(in_filters, in_filters//2))
            in_filters //= 2
        self.last_layer = nn.Sequential(
            nn.Conv2d(in_filters, 1, kernel_size=1, padding=0), nn.Sigmoid())

    def forward(self, x):
        saved_x = []
        x = self.first_layer(x)
        for block in self.blocks_down:
            saved_x.append(x)
            x = block(x)
        for i in range(len(self.blocks_up)):
            x = self.blocks_up[i](x, saved_x[-1-i])
        x = self.last_layer(x)
        return x
