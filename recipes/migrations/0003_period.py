# Generated by Django 2.1.3 on 2019-03-03 23:02

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import uuid


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('recipes', '0002_search'),
    ]

    operations = [
        migrations.CreateModel(
            name='Period',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('start_date', models.DateField()),
                ('end_date', models.DateField()),
                ('author', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='RecipeInPeriod',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('date', models.DateField(blank=True, null=True)),
                ('meal', models.IntegerField(blank=True, choices=[(1, 'breakfast'), (2, 'lunch'), (3, 'snack'), (4, 'dinner')], null=True)),
                ('author', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
                ('period', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='recipes', to='recipes.Period')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.AlterField(
            model_name='recipe',
            name='source',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='recipes', to='recipes.Source'),
        ),
        migrations.AddField(
            model_name='recipeinperiod',
            name='recipe',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='periods', to='recipes.Recipe'),
        ),
    ]