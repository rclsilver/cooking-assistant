"""ingredient

Revision ID: d48e36ff54eb
Revises: 1a9b16f71f5b
Create Date: 2020-11-28 11:47:21.688144

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'd48e36ff54eb'
down_revision = '1a9b16f71f5b'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table('ingredient',
        sa.Column('id', postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('updated_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('label', sa.String(), nullable=False),
        sa.Column('label_plural', sa.String(), nullable=True),
        sa.Column('image_url', sa.String(), nullable=True),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('id'),
        sa.UniqueConstraint('label')
    )
    op.create_index(op.f('ix_ingredient_created_at'), 'ingredient', ['created_at'], unique=False)


def downgrade():
    op.drop_index(op.f('ix_ingredient_created_at'), table_name='ingredient')
    op.drop_table('ingredient')
