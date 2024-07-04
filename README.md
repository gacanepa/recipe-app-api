# recipe-app-api

## Build Instructions

1. Once Docker is installed, run the following command in the root of the repository to build the image:

```bash
docker build .
```

## Viewing Superusers

Run:

```bash
docker-compose run app sh -c 'python manage.py shell'
```

Then run:

```python
from django.contrib.auth import get_user_model
User = get_user_model()
superusers = User.objects.filter(is_superuser=True)
for superuser in superusers:
    print(superuser.id, superuser.email)
```

## Changing a User Password

Run:

```bash
docker-compose run app sh -c 'python manage.py changepassword <user_id>'
```

where `<user_id>` is the ID of the user you want to change the password for.

or, if you're in the Django shell:

```python
from django.contrib.auth import get_user_model
User = get_user_model()
user = User.objects.get(id=<user_id>)
user.set_password('<new_password>')
user.save()
```

where `<user_id>` is the ID of the user you want to change the password for and `<new_password>` is the new password you want to set.