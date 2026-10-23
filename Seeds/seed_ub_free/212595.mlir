module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8> : tensor<3x6x10x2xi32>}> : () -> tensor<3x6x10x2xi32>
    %1 = "tosa.const"() <{values = dense<-180> : tensor<3x6x10x2xi32>}> : () -> tensor<3x6x10x2xi32>
    %2 = "tosa.const"() <{values = dense<7.507000e+01> : tensor<6x1x3xf32>}> : () -> tensor<6x1x3xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<3x6x10x2xi32>}> : () -> tensor<3x6x10x2xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<3x6x10x2xi32>}> : () -> tensor<3x6x10x2xi32>
    %s1 = tosa.maximum %1, %c0 : (tensor<3x6x10x2xi32>, tensor<3x6x10x2xi32>) -> tensor<3x6x10x2xi32>
    %s2 = tosa.minimum %s1, %c31 : (tensor<3x6x10x2xi32>, tensor<3x6x10x2xi32>) -> tensor<3x6x10x2xi32>
    %3 = tosa.logical_right_shift %0, %s2 : (tensor<3x6x10x2xi32>, tensor<3x6x10x2xi32>) -> tensor<3x6x10x2xi32>
    %4 = tosa.sigmoid %2 : (tensor<6x1x3xf32>) -> tensor<6x1x3xf32>
    %5 = tosa.concat %4, %4 {axis = 1 : i32} : (tensor<6x1x3xf32>, tensor<6x1x3xf32>) -> tensor<6x2x3xf32>
    %cast = tensor.cast %3 : tensor<3x6x10x2xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<6x2x3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}