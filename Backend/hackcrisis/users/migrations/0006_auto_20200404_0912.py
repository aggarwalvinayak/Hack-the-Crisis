# Generated by Django 3.0.2 on 2020-04-04 09:12

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0005_auto_20200404_0519'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='people',
            name='lastloc',
        ),
        migrations.AddField(
            model_name='people',
            name='lat',
            field=models.FloatField(default=211),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='people',
            name='lon',
            field=models.FloatField(default=123),
            preserve_default=False,
        ),
    ]
