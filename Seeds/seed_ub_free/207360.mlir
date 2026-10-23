module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-151> : tensor<10x4x1x4xi32>}> : () -> tensor<10x4x1x4xi32>
    %1 = "tosa.const"() <{values = dense<122> : tensor<1x4x1x1xi32>}> : () -> tensor<1x4x1x1xi32>
    %2 = tosa.maximum %0, %1 : (tensor<10x4x1x4xi32>, tensor<1x4x1x1xi32>) -> tensor<10x4x1x4xi32>
    %3 = tosa.concat %2, %2 {axis = 3 : i32} : (tensor<10x4x1x4xi32>, tensor<10x4x1x4xi32>) -> tensor<10x4x1x8xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<10x4x1x8xi32>}> : () -> tensor<10x4x1x8xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<10x4x1x8xi32>}> : () -> tensor<10x4x1x8xi32>
    %a0 = tosa.maximum %3, %c0 : (tensor<10x4x1x8xi32>, tensor<10x4x1x8xi32>) -> tensor<10x4x1x8xi32>
    %b1 = tosa.minimum %a0, %c31 : (tensor<10x4x1x8xi32>, tensor<10x4x1x8xi32>) -> tensor<10x4x1x8xi32>
    %4 = tosa.logical_right_shift %3, %b1 : (tensor<10x4x1x8xi32>, tensor<10x4x1x8xi32>) -> tensor<10x4x1x8xi32>
    %cast = tensor.cast %4 : tensor<10x4x1x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}