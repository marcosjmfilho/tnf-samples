/**
* @license TOTVS | Totvs TNF THF v0.1.0
* (c) 2015-2016 TOTVS S/A https://www.totvs.com
* License: Comercial
*/

/**
* @module totvsProfessional
* @name TotvsProfessionalListController
* @object controller
*
* @created 2017-3-6 v0.1.0
* @updated 2017-3-6 v0.1.0
*
* @requires
*
* @dependencies
*
* @description Controller responsável por listar os registros
*/

(function () {

    'use strict';

    angular
        .module('professional')
        .controller('ProfessionalListController', ProfessionalListController);

    ProfessionalListController.$inject = [
        '$scope',
        '$modal',
        'totvs.app-notification.Service',
        'dateFilter',
        'i18nFilter',
		'professionalFactory'
    ];

    function ProfessionalListController($scope, $modal, notification, dateFilter, i18nFilter, professionalFactory) {

        // *********************************************************************************
		// *** Variables
		// *********************************************************************************

        var self = this,
            advancedSearch = {};

        // *********************************************************************************
		// *** Public Properties and Methods
		// *********************************************************************************

        self.records = [];
		self.recordsCount = 0;
        self.disclaimers = [];
        self.searchText = '';
        self.search = search;
        self.loadRecords = loadRecords;
        self.openAdvancedSearch = openAdvancedSearch;
        self.removeDisclaimer = removeDisclaimer;
        self.applyEdit = applyEdit;
        self.onRemove = onRemove;

        // *********************************************************************************
		// *** Controller Initialize
		// *********************************************************************************

		function init(cacheController) {
            if (!cacheController) {
                // Carregando pela primeira vez
                loadRecords(false);
            } else {
                // Buscando dados iniciais do "cache"
                angular.forEach(cacheController, function(value, property) {
                    self[property] = value;
                });
            }

		}

        // *********************************************************************************
		// *** Events Listners
		// *********************************************************************************

        $scope.$on('$totvsViewServiceInit', function (event, cacheController) {
            init(cacheController);
        });

        // *********************************************************************************
		// *** Functions
		// *********************************************************************************

        function loadRecords(isMore) {
			var parameters = {},
                start = 0;

            // paginação
			self.recordsCount = undefined;

			if (isMore) {
				start = parseInt(self.records.length / 2) + 1;
			} else {
				self.records = [];
			}

            // pesquisa
            if (self.disclaimers.length > 0) {
                angular.forEach(self.disclaimers, function (disclaimer) {
                    if (disclaimer.property && disclaimer.value)
                        parameters[disclaimer.property] = disclaimer.value;
                });
            }

            parameters.page = start;
            parameters.pageSize = 10;

			professionalFactory.findRecords(parameters, function (result) {
				if (result) {
					angular.forEach(result, function (value) {
                        
						if (value && value.$length) {
							self.recordsCount = value.$length;
						}

						self.records.push(value);
					});

                    self.recordsCount = self.recordsCount || result.length;
				} else {
                    self.records = [];
                    self.recordsCount = 0;
                }
			});
		}

        function search() {
            self.disclaimers = [];

            if (self.searchText) {
                addDisclaimer('name', self.searchText, 'Pesquisa: ' + self.searchText);
            }

            self.loadRecords(false);
		}

        function openAdvancedSearch() {
			var modalInstance = $modal.open({
                templateUrl: '/js/professionals/professionals-search.view.html',
                controller: 'ProfessionalSearchController as controller',
                size: 'md',
                resolve: {
                    data: function () {
                        return angular.copy(advancedSearch);
                    }
                }
            });

            modalInstance.result.then(function (params) {
                advancedSearch = angular.copy(params)

                addDisclaimers();
            });
		}

        function addDisclaimer(property, value, label) {
            self.disclaimers.push({
                property: property,
                value: value,
                title: label
            });
        }

        function addDisclaimers() {

            var filter = angular.copy(advancedSearch);

            removeDisclaimers();

            if (filter.name) {
                addDisclaimer('name', filter.name, 'Nome igual a "' + filter.name + '"');
            }

            if (filter.phone) {
                addDisclaimer('phone', filter.phone, 'Telefone igual a "' + filter.phone + '"');
            }

            if (filter.email) {
                addDisclaimer('email', filter.email, 'Email igual a "' + filter.email + '"');
            }

            if (filter.address.zipCode.number) {
                addDisclaimer('zipCode', filter.address.zipCode.number, 'Código Postal igual a "' + filter.address.zipCode.number + '"');
            }

            self.loadRecords(false);
        }

        function removeDisclaimer(disclaimer) {
            // pesquisa e remove o disclaimer do array
            var index = self.disclaimers.indexOf(disclaimer);

            if (index !== -1) {
                self.disclaimers.splice(index, 1);
            }

            if (disclaimer.property === 'name') {
                self.searchText = '';
            }

            self.loadRecords();
        }

        function removeDisclaimers() {
            self.disclaimers = [];
        }

        function applyEdit(newValue, field, professional) {
            var update = {};

            if (newValue !== professional[field]) {
                update[field] = newValue;

                professionalFactory.updateRecord(professional.professionalId, professional.code, update);
            }
        }

		function onRemove(record) {
            notification.question({
				title: 'l-question',
				text: i18nFilter('l-confirm-delete-operation'),
				cancelLabel: 'l-no',
				confirmLabel: 'l-yes',
				callback: function (isPositiveResult) {
                    var index;

					if (isPositiveResult) {
						professionalFactory.deleteRecord(record.professionalId, record.code, function (result) {
							if (result) {

								index = self.records.indexOf(record);

								if (index !== -1) {
									self.records.splice(index, 1);
									self.recordsCount -= 1;
								}
							}
						});
					}
				}
			});
		}
	};

}());
