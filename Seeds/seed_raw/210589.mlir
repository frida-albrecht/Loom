module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<185> : tensor<3x4x2xi64>}> : () -> tensor<3x4x2xi64>
    %1 = tosa.identity %0 : (tensor<3x4x2xi64>) -> tensor<3x4x2xi64>
    %2 = tosa.reduce_product %1 {axis = 2 : i32} : (tensor<3x4x2xi64>) -> tensor<3x4x1xi64>
    %cast = tensor.cast %2 : tensor<3x4x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

