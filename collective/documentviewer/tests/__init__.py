from collective.documentviewer.testing import \
    DocumentViewer_INTEGRATION_TESTING
from plone.app.testing import setRoles, login
import unittest
from plone.namedfile.file import NamedBlobFile
from plone.app.testing import TEST_USER_ID, TEST_USER_NAME
from collective.documentviewer.testing import createObject
from os.path import join
from os.path import dirname
from collective.documentviewer.interfaces import ILayer
from zope.interface import alsoProvides

_files = join(dirname(__file__), 'test_files')


class BaseTest(unittest.TestCase):

    layer = DocumentViewer_INTEGRATION_TESTING

    def setUp(self):
        self.portal = self.layer['portal']
        self.request = self.layer['request']
        alsoProvides(self.request, ILayer)
        setRoles(self.portal, TEST_USER_ID, ['Manager'])
        from collective.documentviewer import async
        self.origFunc = async.asyncInstalled
        async.asyncInstalled = lambda: False

    def tearDown(self):
        from collective.documentviewer import async
        async.asyncInstalled = self.origFunc

    def createFile(self, name=u"test.pdf", id='test1'):
        setRoles(self.portal, TEST_USER_ID, ('Manager', ))
        login(self.portal, TEST_USER_NAME)
        file = NamedBlobFile(data=open(join(_files, name), 'r').read(), filename=unicode(name))
#                             contentType='application/pdu)
        fi = createObject(self.portal, 'File', id,
            file=file)
        return fi
