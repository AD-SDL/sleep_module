"""
REST-based node that interfaces with WEI and provides a simple Sleep(t) function
"""

import time
from pathlib import Path

from fastapi.datastructures import State
from typing_extensions import Annotated
from wei.modules.rest_module import RESTModule
from wei.types.step_types import ActionRequest, StepResponse, StepStatus
from wei.utils import extract_version

rest_module = RESTModule(
    name="sleep_node",
    version=extract_version(Path(__file__).parent.parent / "pyproject.toml"),
    description="An example node that sleeps for a time ",
    model="sleeper",
)


@rest_module.action(name="sleep", description="An action that sleeps for t seconds")
def sleep(
    state: State,
    action: ActionRequest,
    t: Annotated[int, "time in seconds to sleep for"],
) -> StepResponse:
    """
    Sleeps the module for t seconds
    """

    time.sleep(int(t))
    return StepResponse(
        action_response=StepStatus.SUCCEEDED,
        action_msg="",
        action_log="",
    )


if __name__ == "__main__":
    rest_module.start()
