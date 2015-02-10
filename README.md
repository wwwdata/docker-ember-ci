# docker-ember-ci
Docker Image with nodejs, bower, ember-cli and sshd to run tests via jenkins ci

## Usage
Start the container with this command. You should mount a file `authorized_keys` to the `/home/docker/.ssh` folder to authorize the user docker.

```bash
docker run -d -p 8000:22 -v /data/ssh-config:/home/docker/.ssh --name nodejs docker-ember-ci
```
