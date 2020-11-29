"""recipe_ingredient

Revision ID: b6ca8e40a566
Revises: d48e36ff54eb
Create Date: 2020-11-28 18:28:12.928752

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'b6ca8e40a566'
down_revision = 'd48e36ff54eb'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table('recipe_ingredient',
        sa.Column('id', postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('updated_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('quantity', sa.Float(), nullable=True),
        sa.Column('optional', sa.Boolean(), nullable=True),
        sa.Column('recipe_id', postgresql.UUID(), nullable=False),
        sa.Column('ingredient_id', postgresql.UUID(), nullable=False),
        sa.Column('unit_id', postgresql.UUID(), nullable=True),
        sa.ForeignKeyConstraint(['ingredient_id'], ['ingredient.id'], ),
        sa.ForeignKeyConstraint(['recipe_id'], ['recipe.id'], ),
        sa.ForeignKeyConstraint(['unit_id'], ['unit.id'], ),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('id'),
        sa.UniqueConstraint('recipe_id', 'ingredient_id', name='recipe_ingredient_uc')
    )
    op.create_index(op.f('ix_recipe_ingredient_created_at'), 'recipe_ingredient', ['created_at'], unique=False)


def downgrade():
    op.drop_index(op.f('ix_recipe_ingredient_created_at'), table_name='recipe_ingredient')
    op.drop_table('recipe_ingredient')
