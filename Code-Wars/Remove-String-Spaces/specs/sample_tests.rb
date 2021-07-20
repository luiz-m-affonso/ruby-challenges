describe 'Basic tests' do
  it 'should pass with given strings' do
    Test.assert_equals(no_space(' A B   H D'))
    Test.assert_equals(no_space(' B  B  F  D'))
    Test.assert_equals(no_space(' E B  J  D'))
  end
end