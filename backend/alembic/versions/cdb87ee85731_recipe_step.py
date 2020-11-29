"""recipe_step

Revision ID: cdb87ee85731
Revises: b6ca8e40a566
Create Date: 2020-11-29 14:46:34.967319

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'cdb87ee85731'
down_revision = 'b6ca8e40a566'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table('recipe_step',
        sa.Column('id', postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('updated_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('order', sa.Integer(), nullable=False),
        sa.Column('content', sa.String(), nullable=False),
        sa.Column('recipe_id', postgresql.UUID(), nullable=False),
        sa.ForeignKeyConstraint(['recipe_id'], ['recipe.id'], ),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('id'),
        sa.UniqueConstraint('recipe_id', 'order', name='recipe_order_uc')
    )
    op.create_index(op.f('ix_recipe_step_created_at'), 'recipe_step', ['created_at'], unique=False)


def downgrade():
    op.drop_index(op.f('ix_recipe_step_created_at'), table_name='recipe_step')
    op.drop_table('recipe_step')
