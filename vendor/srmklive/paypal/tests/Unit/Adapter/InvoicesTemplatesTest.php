<?php

namespace Srmklive\PayPal\Tests\Unit\Adapter;

use PHPUnit\Framework\TestCase;
use Srmklive\PayPal\Tests\MockClientClasses;
use Srmklive\PayPal\Tests\MockRequestPayloads;
use Srmklive\PayPal\Tests\MockResponsePayloads;

class InvoicesTemplatesTest extends TestCase
{
    use MockClientClasses;
    use MockRequestPayloads;
    use MockResponsePayloads;

    /** @test */
    public function it_can_create_invoice_template()
    {
        $expectedResponse = $this->mockCreateInvoiceTemplateResponse();

        $expectedParams = $this->mockCreateInvoiceTemplateParams();

        $expectedMethod = 'createInvoiceTemplate';

        $mockClient = $this->mock_client($expectedResponse, $expectedMethod, true);

        $mockClient->setApiCredentials($this->getMockCredentials());
        $mockClient->getAccessToken();

        $this->assertEquals($expectedResponse, $mockClient->{$expectedMethod}($expectedParams));
    }

    /** @test */
    public function it_can_list_invoice_templates()
    {
        $expectedResponse = $this->mockListInvoiceTemplateResponse();

        $expectedMethod = 'listInvoiceTemplates';

        $mockClient = $this->mock_client($expectedResponse, $expectedMethod, true);

        $mockClient->setApiCredentials($this->getMockCredentials());
        $mockClient->getAccessToken();

        $this->assertEquals($expectedResponse, $mockClient->{$expectedMethod}());
    }

    /** @test */
    public function it_can_delete_an_invoice_template()
    {
        $expectedResponse = '';

        $expectedMethod = 'deleteInvoiceTemplate';

        $mockClient = $this->mock_client($expectedResponse, $expectedMethod, true);

        $mockClient->setApiCredentials($this->getMockCredentials());
        $mockClient->getAccessToken();

        $this->assertEquals($expectedResponse, $mockClient->{$expectedMethod}('TEMP-19V05281TU309413B'));
    }

    /** @test */
    public function it_can_update_an_invoice_template()
    {
        $expectedResponse = $this->mockUpdateInvoiceTemplateResponse();

        $expectedParams = $this->mockUpdateInvoiceTemplateParams();

        $expectedMethod = 'updateInvoiceTemplate';

        $mockClient = $this->mock_client($expectedResponse, $expectedMethod, true);

        $mockClient->setApiCredentials($this->getMockCredentials());
        $mockClient->getAccessToken();

        $this->assertEquals($expectedResponse, $mockClient->{$expectedMethod}('TEMP-19V05281TU309413B', $expectedParams));
    }

    /** @test */
    public function it_can_get_details_for_an_invoice_template()
    {
        $expectedResponse = $this->mockGetInvoiceTemplateResponse();

        $expectedMethod = 'showInvoiceTemplateDetails';

        $mockClient = $this->mock_client($expectedResponse, $expectedMethod, true);

        $mockClient->setApiCredentials($this->getMockCredentials());
        $mockClient->getAccessToken();

        $this->assertEquals($expectedResponse, $mockClient->{$expectedMethod}('TEMP-19V05281TU309413B'));
    }
}
