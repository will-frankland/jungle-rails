/// <reference types="cypress" />

describe('Homepage vist test', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
  })
  it('Should display the homepage', () => {

  })
  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });
});