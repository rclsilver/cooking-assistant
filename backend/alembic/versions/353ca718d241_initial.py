"""initial

Revision ID: 353ca718d241
Revises: 
Create Date: 2020-11-15 09:29:06.070971

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '353ca718d241'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    op.create_table(
        'user',
        sa.Column('id', postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('updated_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('username', sa.String(), nullable=False),
        sa.Column('is_admin', sa.Boolean(), server_default=sa.text('false'), nullable=False),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('id'),
        sa.UniqueConstraint('username')
    )
    op.create_index(op.f('ix_user_created_at'), 'user', ['created_at'], unique=False)
    op.create_table(
        'recipe',
        sa.Column('id', postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('updated_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('title', sa.String(), nullable=True),
        sa.Column('image_url', sa.String(), nullable=True),
        sa.Column('url', sa.String(), nullable=False),
        sa.Column('author_id', postgresql.UUID(), nullable=True),
        sa.ForeignKeyConstraint(['author_id'], ['user.id'], ),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('id'),
        sa.UniqueConstraint('url')
    )
    op.create_index(op.f('ix_recipe_created_at'), 'recipe', ['created_at'], unique=False)


def downgrade():
    op.drop_index(op.f('ix_recipe_created_at'), table_name='recipe')
    op.drop_table('recipe')
    op.drop_index(op.f('ix_user_created_at'), table_name='user')
    op.drop_table('user')
