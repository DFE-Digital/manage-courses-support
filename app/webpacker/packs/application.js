import "../stylesheets/application.scss";
import Rails from 'rails-ujs';
import { initAll } from "govuk-frontend";

Rails.start();
initAll();
