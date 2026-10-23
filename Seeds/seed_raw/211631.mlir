module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<118> : tensor<6x6xi64>}> : () -> tensor<6x6xi64>
    %1 = tosa.const_shape  {values = dense<[1, 6, 1, 6]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<6x6xi64>, !tosa.shape<4>) -> tensor<1x6x1x6xi64>
    %3 = "tosa.const"() <{values = dense<[2, 3, 1, 0]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %4 = tosa.transpose %2 {perms = array<i32: 0, 1, 3, 2>} : (tensor<1x6x1x6xi64>) -> tensor<1x6x6x1xi64>
    %cast = tensor.cast %4 : tensor<1x6x6x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

