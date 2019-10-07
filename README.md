# Chemical Mechanisms Optimizer
5/08/2017 Jordan Lee (unghee@umich.edu)1
#About Mechanisms Optimizer  
The  optimizer  optimizes  reaction  rate  parameters(pre-exponential  and  activation energyterms)  in  the  selected  reactions  in  the chemicalmechanism in Chemkin  format.  The optimizerruns  in  MATLAB  framework. Chemkin  homogeneous  reactor  simulationsare  usedto calculate 0-D ignition delay time.

# 2 Files description in the optimizer 
The homogeneous reactor code in Chemkin is used. For a detailed description on this code, please refer to CHEMKIN ignition delay calculations manual. The flow chart of the entire process is as below.In whole, the optimizer is composed of sensitivity analysis sectionand 

<img src= "https://github.com/unghee/JPoptimization_github/blob/master/images/optimizer_flow.png">
