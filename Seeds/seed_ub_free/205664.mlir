module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<107> : tensor<10x10x8x5xi32>}> : () -> tensor<10x10x8x5xi32>
    %1 = "tosa.const"() <{values = dense<161> : tensor<10x1x1x1xi32>}> : () -> tensor<10x1x1x1xi32>
    %2 = "tosa.const"() <{values = dense<-6.510000e+00> : tensor<9x10x8x6xf32>}> : () -> tensor<9x10x8x6xf32>
    %3 = "tosa.const"() <{values = dense<-5.662000e+01> : tensor<1x1x8x6xf32>}> : () -> tensor<1x1x8x6xf32>
    %4 = tosa.intdiv %0, %1 : (tensor<10x10x8x5xi32>, tensor<10x1x1x1xi32>) -> tensor<10x10x8x5xi32>
    %5 = tosa.const_shape  {values = dense<[2, 3, 1, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.tile %4, %5 : (tensor<10x10x8x5xi32>, !tosa.shape<4>) -> tensor<20x30x8x15xi32>
    %c_val0 = "tosa.const"() <{values = dense<0.0> : tensor<9x10x8x6xf32>}> : () -> tensor<9x10x8x6xf32>
    %v_tmp0 = tosa.maximum %2, %c_val0 : (tensor<9x10x8x6xf32>, tensor<9x10x8x6xf32>) -> tensor<9x10x8x6xf32>
    %c_val1 = "tosa.const"() <{values = dense<1.0> : tensor<9x10x8x6xf32>}> : () -> tensor<9x10x8x6xf32>
    %v_tmp1 = tosa.maximum %v_tmp0, %c_val1 : (tensor<9x10x8x6xf32>, tensor<9x10x8x6xf32>) -> tensor<9x10x8x6xf32>
    %7 = tosa.pow %v_tmp1, %3 : (tensor<9x10x8x6xf32>, tensor<1x1x8x6xf32>) -> tensor<9x10x8x6xf32>
    %8 = tosa.floor %7 : (tensor<9x10x8x6xf32>) -> tensor<9x10x8x6xf32>
    %cast = tensor.cast %6 : tensor<20x30x8x15xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<9x10x8x6xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}