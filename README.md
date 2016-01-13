# Kaggle

Collaborating on Kaggle competitions

## Repo contents

IPython notebooks and submissions (note that GitHub now directly renders IPython Notebooks in the browser. When you open the `ipynb` file it will render it. Awesome!):

- `whats-cooking`: The [What's Cooking](https://www.kaggle.com/c/whats-cooking) challenge.
    - NN submission at the botton gets LB accuracy of 0.79133 (~385th place).
    - Good overview of how to cross-validate an elastic net based logistic regression model too.
    - Also shows how to run deep neural networks on AWS EC2 on the AMI described below.

Other utilities:

- `packer` contains configuration required to get Packer to generate an Amazon EC2 AMI for g2.2xlarge instances to enable running machine learning tasks on Theano-based packages, e.g. Lasagne and keras.
    - To use it run:

```
export AWS_ACCESS_KEY_ID=MY_ACCESS_KEY
export AWS_SECURE_ACCESS_KEY=MY_SECURE_ACCESS_KEY
PACKER_LOG=1 packer build --only=amazon-ebs packer/build.json
```

## How to run on Amazon EC2

I've created an EBS-backed AMI with ID `ami-ada3f8c7` in region `us-east-1` which, when run on a g2.2xlarge instance, will support running deep neural network machine learning models. An example of this is contained in the "What's Cooking" directory.

One-click link to start launching an instance of this AMI is here:

https://console.aws.amazon.com/ec2/home?region=us-east-1#launchAmi=ami-ada3f8c7

Note that when you launch this AMI:

- Only launch this AMI on a `g2.2xlarge` instance.
- Since I've created the AMI in `us-east-1` you must use an EC2 keypair created in `us-east-1`, and also launch your instances there too. If needed I can make the instance in different regions too.
- Set up the security group to allow access to TCP port 8192.
- When the instance is launched use the public DNS entry to access `http://<public DNS name>:8192`. This will give you access to a IPython Notebook server.

