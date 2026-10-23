module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<53> : tensor<5x8x4xi64>}> : () -> tensor<5x8x4xi64>
    %1 = tosa.const_shape  {values = dense<[40, 4]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<5x8x4xi64>, !tosa.shape<2>) -> tensor<40x4xi64>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<40x4xi64>) -> tensor<40x4xi64>
    %cast = tensor.cast %3 : tensor<40x4xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

