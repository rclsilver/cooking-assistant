"""user_is_admin

Revision ID: 353ca718d241
Revises: 2179d37aaaf8
Create Date: 2020-11-22 10:47:38.494346

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '353ca718d241'
down_revision = '2179d37aaaf8'
branch_labels = None
depends_on = None


def upgrade():
    op.add_column('user', sa.Column('is_admin', sa.Boolean(), server_default=sa.text('false'), nullable=False))


def downgrade():
    op.drop_column('user', 'is_admin')
