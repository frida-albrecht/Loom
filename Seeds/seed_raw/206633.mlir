module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<164> : tensor<3x1x4xi32>}> : () -> tensor<3x1x4xi32>
    %1 = tosa.const_shape  {values = dense<[6, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.reshape %0, %1 : (tensor<3x1x4xi32>, !tosa.shape<3>) -> tensor<6x2x1xi32>
    %3 = tosa.clamp %2 {max_val = 157 : i32, min_val = 52 : i32} : (tensor<6x2x1xi32>) -> tensor<6x2x1xi32>
    %4 = tosa.argmax %3 {axis = 1 : i32} : (tensor<6x2x1xi32>) -> tensor<6x1xi32>
    %5 = tosa.intdiv %4, %4 : (tensor<6x1xi32>, tensor<6x1xi32>) -> tensor<6x1xi32>
    %cast = tensor.cast %5 : tensor<6x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

