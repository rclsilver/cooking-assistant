"""planning

Revision ID: c0c5a3b97ab1
Revises: 353ca718d241
Create Date: 2020-11-27 11:18:01.356177

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'c0c5a3b97ab1'
down_revision = '353ca718d241'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table('recipe_schedule',
        sa.Column('id', postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('updated_at', sa.DateTime(timezone=True), nullable=False),
        sa.Column('date', sa.Date(), nullable=False),
        sa.Column('recipe_id', postgresql.UUID(), nullable=False),
        sa.Column('author_id', postgresql.UUID(), nullable=False),
        sa.ForeignKeyConstraint(['author_id'], ['user.id'], ),
        sa.ForeignKeyConstraint(['recipe_id'], ['recipe.id'], ),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('id'),
        sa.UniqueConstraint('recipe_id', 'date', name='recipe_date_uc')
    )
    op.create_index(op.f('ix_recipe_schedule_created_at'), 'recipe_schedule', ['created_at'], unique=False)
    op.create_index(op.f('ix_recipe_schedule_date'), 'recipe_schedule', ['date'], unique=False)


def downgrade():
    op.drop_index(op.f('ix_recipe_schedule_date'), table_name='recipe_schedule')
    op.drop_index(op.f('ix_recipe_schedule_created_at'), table_name='recipe_schedule')
    op.drop_table('recipe_schedule')
