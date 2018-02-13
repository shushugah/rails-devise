# frozen_string_literal: true

describe User do
  let(:user) { create(:user, email: 'email@1.com') }

  it { should respond_to(:email) }

  it '#email returns a string' do
    expect(user.email).to match 'email@1.com'
  end

  def new_updated_email(*numbers)
    numbers.each do |n|
      user.email = "email@#{n}.com"
      user.save
    end
  end

  context 'when updating single email' do
    it 'persists changed email' do
      expect(user).to receive(:persist_user_emails).once

      new_updated_email(2)
    end

    it 'does not persist unchanged email' do
      expect(user).to_not receive(:persist_user_emails)

      new_updated_email(1)
    end
  end

  context 'when updating unique emails' do
    it 'persist two changed emails' do
      expect(user).to receive(:persist_user_emails).twice

      new_updated_email(2, 3)
    end

    it 'persist emails when changing back to original email' do
      expect(user).to receive(:persist_user_emails).twice

      new_updated_email(2, 1)
    end

    it 'persist only unique emails' do
      expect(user).to receive(:persist_user_emails).twice

      new_updated_email(1, 2, 1)
    end
  end
end
