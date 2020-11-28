"""unit

Revision ID: 1a9b16f71f5b
Revises: c0c5a3b97ab1
Create Date: 2020-11-28 09:06:59.625871

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '1a9b16f71f5b'
down_revision = 'c0c5a3b97ab1'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table('unit',
        sa.Column('id', postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('updated_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('label', sa.String(), nullable=False),
        sa.Column('label_plural', sa.String(), nullable=True),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('id'),
        sa.UniqueConstraint('label')
    )
    op.create_index(op.f('ix_unit_created_at'), 'unit', ['created_at'], unique=False)


def downgrade():
    op.drop_index(op.f('ix_unit_created_at'), table_name='unit')
    op.drop_table('unit')
