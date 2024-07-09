"""
Django admin customization
"""

from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.utils.translation import gettext_lazy as _

from core import models


class UserAdmin(BaseUserAdmin):
    # Specifies the default ordering of users in the admin list view
    ordering = ['id']
    # Defines which fields of the user model are displayed in the list view,
    list_display = ['email', 'name']
    # Each inner tuple represents a section (which consists of an optional title and a dictionary of options)
    fieldsets = (
        # First section: None means no title
        (None, {"fields": ("email", "password")}),
        # Second section: Personal Info title
        (_("Personal Info"), {"fields": ("name",)}),
        # Third section: Permissions title (_ is a convention for translation)
        (_("Permissions"), {"fields": ("is_active", "is_staff", "is_superuser")}),
        # Fourth section: Important dates
        (_("Important dates"), {"fields": ("last_login",)}),
    )
    readonly_fields = ('last_login',)

    # The add_fieldsets attribute is the same as fieldsets, but for the add page
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'password', 'password_confirmation')
        }),
    )

# Register the User model with the custom UserAdmin to the admin site
admin.site.register(models.User, UserAdmin)
