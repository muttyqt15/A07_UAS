# Generated by Django 5.0.2 on 2024-10-24 21:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('thread', '0002_remove_thread_title_alter_comment_content_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comment',
            name='id',
            field=models.UUIDField(auto_created=True, editable=False, primary_key=True, serialize=False, unique=True),
        ),
        migrations.AlterField(
            model_name='thread',
            name='id',
            field=models.UUIDField(auto_created=True, editable=False, primary_key=True, serialize=False, unique=True),
        ),
    ]