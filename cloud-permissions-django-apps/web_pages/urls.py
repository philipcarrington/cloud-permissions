from django.urls import path
from web_pages import views

urlpatterns = [
    path('', views.hello_world, name='hello_world'),
]