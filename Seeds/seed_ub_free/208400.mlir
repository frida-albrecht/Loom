module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-89> : tensor<2x4xi32>}> : () -> tensor<2x4xi32>
    %1 = "tosa.const"() <{values = dense<-7> : tensor<1x4xi32>}> : () -> tensor<1x4xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<2x4xi32>, tensor<1x4xi32>) -> tensor<2x4xi32>
    %3 = tosa.reduce_sum %2 {axis = 1 : i32} : (tensor<2x4xi32>) -> tensor<2x1xi32>
    %4 = tosa.clamp %3 {max_val = 97 : i32, min_val = -21 : i32} : (tensor<2x1xi32>) -> tensor<2x1xi32>
    %5 = tosa.concat %4, %3 {axis = 1 : i32} : (tensor<2x1xi32>, tensor<2x1xi32>) -> tensor<2x2xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %clamped_lower = tosa.maximum %5, %c0 : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
    %clamped_shift = tosa.minimum %clamped_lower, %c31 : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
    %6 = tosa.logical_right_shift %5, %clamped_shift : (tensor<2x2xi32>, tensor<2x2xi32>) -> tensor<2x2xi32>
    %cast = tensor.cast %6 : tensor<2x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}