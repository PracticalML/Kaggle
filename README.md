# Kaggle

Collaborating on Kaggle competitions

## Repo contents

- `packer` contains configuration required to get Packer to generate an Amazon EC2 AMI for g2.2xlarge instances to enable running machine learning tasks on Theano-based packages, e.g. Lasagne and keras.
    - To use it run:

```
export AWS_ACCESS_KEY_ID=MY_ACCESS_KEY
export AWS_SECURE_ACCESS_KEY=MY_SECURE_ACCESS_KEY
PACKER_LOG=1 packer build --only=amazon-ebs packer/build.json
```
