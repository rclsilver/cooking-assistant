"""recipe_url_nullable

Revision ID: 78469753a4e1
Revises: cdb87ee85731
Create Date: 2020-11-30 11:15:50.331002

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '78469753a4e1'
down_revision = 'cdb87ee85731'
branch_labels = None
depends_on = None


def upgrade():
    op.alter_column('recipe', 'url', existing_type=sa.VARCHAR(), nullable=True)
    op.drop_constraint('recipe_url_key', 'recipe', type_='unique')


def downgrade():
    op.create_unique_constraint('recipe_url_key', 'recipe', ['url'])
    op.alter_column('recipe', 'url', existing_type=sa.VARCHAR(), nullable=False)
