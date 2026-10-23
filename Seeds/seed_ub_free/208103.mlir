module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<42> : tensor<10x4x4x3xi64>}> : () -> tensor<10x4x4x3xi64>
    %1 = tosa.reverse %0 {axis = 2 : i32} : (tensor<10x4x4x3xi64>) -> tensor<10x4x4x3xi64>
    %2 = tosa.reduce_min %1 {axis = 3 : i32} : (tensor<10x4x4x3xi64>) -> tensor<10x4x4x1xi64>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<10x4x4x1xi64>) -> tensor<10x4x4x1xi64>
    %cast = tensor.cast %3 : tensor<10x4x4x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

