# frozen_string_literal: true

require 'rails_helper'

describe API::V1::Tasks, type: :request do
  let(:task) { create(:task) }
  let(:task_attributes) { attributes_for(:task) }
  let(:url) { '/api/v1/tasks' }
  let(:params) { {} }
  let(:request_params) { [url, params] }

  describe 'GET tasks' do
    subject { -> { get url } }
    it { -> { is_expected.to have_http_status(200) } }
  end

  describe 'CREATE task' do
    let(:params) { { params: { task: task_attributes } } }
    
    subject { -> { post(*request_params) } }
    it { -> { is_expected.to have_http_status(200) } }
  end

  describe 'GET task' do
    before { url << "/#{task.id}" }

    subject { -> { get(*request_params) } }
    it { -> { is_expected.to have_http_status(200) } }
  end

  describe 'UPDATE task' do
    let(:params) { { params: { task: task_attributes } } }
    before { url << "/#{task.id}" }

    subject { -> { patch(*request_params) } }
    it { -> { is_expected.to have_http_status(200) } }
  end

  describe 'DESTROY task' do
    before { url << "/#{task.id}" }
    
    subject { -> { patch(*request_params) } }
    it { -> { is_expected.to have_http_status(200) } }
  end
end
