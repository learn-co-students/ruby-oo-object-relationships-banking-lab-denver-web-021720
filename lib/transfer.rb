class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, transfer_amount)
    @sender = sender 
    @receiver = receiver
    @status = "pending"
    @amount = transfer_amount
  end

  def valid?
    @sender.valid? && @receiver.valid? && @sender.balance >= @amount
  end

  def execute_transaction
    if @status == "pending"
      if self.valid?
        @receiver.deposit(@amount)
        @sender.balance -= @amount
        @status = "complete"
      else
        @status = "rejected"
        return "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer
    if @status == "complete"
      @receiver.balance -= @amount
      @sender.balance += @amount 
      @status = "reversed"
    end
  end
end
