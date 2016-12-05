### Image to generate dcos token for non interactive login with google


```
./login_script.sh $(docker run -it lusu777/auto-dcos-token --url=https://dcos.example.com/login?redirect_uri=urn:ietf:wg:oauth:2.0:oob --user=googleaccount@gmail.com --pass=pass)

```
