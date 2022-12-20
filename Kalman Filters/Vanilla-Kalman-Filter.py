import numpy as np
from matplotlib import pyplot as plt
from filterpy.kalman import KalmanFilter

class kalmanFilter:
    def __init__(self, xDim, zDim):
        self.xDim = xDim
        self.zDim = zDim

        self.x = None
        self.P = None
        self.F = None
        self.Q = None
        self.H = None
        self.R = None

        self.z = None
        self.xPredict = None
        self.PPredict = None
        self.kalmanGain = None
        self.posHistory1 = []

        self.posHistory2 = []
    
    def statePredict(self):
        self.xPredict = self.F @ self.x
        self.PPredict = self.F @ self.P @ self.F.T + self.Q

    def stateUpdate(self, z):
        self.z = z
        residual = self.z - self.H@self.xPredict
        if self.R.size == 1:
            self.kalmanGain = self.PPredict@self.H.T @ (1/(self.H@self.PPredict@self.H.T + self.R))
        else:
            self.kalmanGain = self.PPredict@self.H.T @ np.linalg.inv(self.H@self.PPredict@self.H.T + self.R)
        self.x = self.xPredict + (self.kalmanGain@residual)
        self.P = (1-self.kalmanGain@self.H)@self.PPredict
        self.posHistory1.append(self.xPredict[0])
        self.posHistory2.append(self.x[0])

def get_sensor_reading(dim=1, mean=0, var=1):
    z = np.random.normal(mean, var, dim)
    return z

if __name__ == "__main__":
    kf = KalmanFilter(dim_x=2, dim_z=1)

    #kf = kalmanFilter(xDim=2,zDim=1)
    kf.x = np.array([[0],[0]])
    print(kf.x.shape)
    kf.P = np.diag([500,500])
    t = 0.1
    kf.F = np.array([[1,t],[0,1]])
    kf.Q = np.array([[0,0],[0,0.001]])
    kf.H = np.array([[1,0]])
    kf.R = np.array([[5]]) 

    for i in range(100):
        kf.statePredict()
        z = get_sensor_reading(dim=(1,1),mean=20,var=1)
        kf.stateUpdate(z)
    plt.plot(kf.posHistory1)
    plt.show()

    plt.plot(kf.posHistory2)
    plt.show()
    #print("State after Update", kf.x)
