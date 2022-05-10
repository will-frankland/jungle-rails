/// <reference types="cypress" />

describe('Homepage vist test', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
  })
  it('Should display the homepage', () => {

  })
  it("Should allow the user to sign in and redirect to homepage", () => {
    cy.get('[href="/signup"]').click()
    cy.get('#user_name').click({force: true}).type('Horace III')
    cy.get('#user_email').click({force: true}).type('3@constable.com')
    cy.get('#user_password').click({force: true}).type('police99!')
    cy.get('#user_password_confirmation').click({force: true}).type('police99!')
    cy.get('[type="submit"]').click()
    cy.get('[href="/logout"]').click({force: true})
    cy.get('#email').click({force: true}).type('3@constable.com')
    cy.get('#password').click({force: true}).type('police99!')
    cy.get('[type="submit"]').click({force: true})

  });


});