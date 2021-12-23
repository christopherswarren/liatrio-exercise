let moment = require('moment');
const chai = require('chai');
const expect = require('chai').expect;

chai.use(require('chai-http'));

const app = require('../src/server.js');
let timevalue = moment().unix();

describe('API endpoint /time', function() {
  this.timeout(5000);

  it('should display current time', function() {
    return chai.request(app)
      .get('/time')
      .then(function(res) {
        expect(res).to.have.status(200);
        expect(res).to.be.json;
        expect(res.body).to.be.an('object');
        expect(res.body.timestamp).to.equal(timevalue);
      });
  });
  
  it('should display static message', function() {
    return chai.request(app)
      .get('/time')
      .then(function(res) {
        expect(res).to.have.status(200);
        expect(res).to.be.json;
        expect(res.body).to.be.an('object');
        expect(res.body.message).to.equal("Automate all the things!");
      });
  });

});