# Take the base MXNet Container
FROM 763104351884.dkr.ecr.us-east-1.amazonaws.com/mxnet-training:1.4.0-cpu-py36-ubuntu16.04

# ARG AWS_ACCESS_KEY_ID
# ARG AWS_SECRET_ACCESS_KEY
# ARG AWS_SESSION_TOKEN
ARG AWS_DEFAULT_REGION
ARG AWS_CONTAINER_CREDENTIALS_RELATIVE_URI

# Install aws cli
ADD awscli-bundle $HOME/awscli-bundle
RUN ./awscli-bundle/install -b /usr/local/bin/aws
RUN echo $PATH
RUN aws --version
RUN aws s3 ls

# for security reason, docker in docker, it is not allowed to use aws config or ENV virables
# It will show "The AWS Access Key Id you provided does not exist in our records"
# RUN echo -e "protocol=https\npath=/v1/repos/mxnet-1.4.0\nhost=git-codecommit.us-east-1.amazonaws.com" | aws codecommit credential-helper get --debug
# RUN aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID \
# && aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY \
# && aws configure set default.region $AWS_DEFAULT_REGION

# Add Custom stack of code
RUN git config --global credential.helper '!aws codecommit credential-helper $@'
RUN git config --global credential.UseHttpPath true
RUN git clone "https://git-codecommit.us-east-1.amazonaws.com/v1/repos/mxnet-1.4.0"

ENTRYPOINT ["python", "/mxnet-1.4.0/example/image-classification/train_mnist.py"]