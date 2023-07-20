class User < ApplicationRecord
  has_many :enrollments
  has_many :programs, through: :enrollments
  has_many :teachers, through: :enrollments, source: :teacher
  has_many :favorite_enrollments, -> { where(favorite: true) }, class_name: 'Enrollment'
  has_many :favorites, through: :favorite_enrollments, source: :teacher

  enum kind: { student: 0, teacher: 1, student_teacher: 2 }

  validates :name, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 0 }

  validate :validate_kind_based_on_enrollments

  def self.classmates(user)
    program_ids = user.enrollments.pluck(:program_id)
    User.includes(:enrollments)
      .where(enrollments: { program_id: program_ids })
      .where.not(id: user.id)
  end

  def favorite_teachers
    try(:teachers).includes(:enrollments).where(enrollments: { favorite: true }).where(kind: :teacher)
  end

  private

  def validate_kind_based_on_enrollments
    return unless kind_changed?
    teacher = Enrollment.where(teacher: self)

    if teacher? && enrollments.exists?
      errors.add(:kind, "can not be teacher because is studying in at least one program")
    elsif student? && teacher.exists?
      errors.add(:kind, "can not be student because is teaching in at least one program")
    end
  end
end