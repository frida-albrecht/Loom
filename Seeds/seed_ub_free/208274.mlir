module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-93.459999> : tensor<2x6x9xf32>}> : () -> tensor<2x6x9xf32>
    %1 = "tosa.const"() <{values = dense<-9.943000e+01> : tensor<2x9x8xf32>}> : () -> tensor<2x9x8xf32>
    %2 = "tosa.const"() <{values = dense<-4> : tensor<7x6x2x7xi8>}> : () -> tensor<7x6x2x7xi8>
    %3 = "tosa.const"() <{values = dense<-7> : tensor<7x6x1x1xi8>}> : () -> tensor<7x6x1x1xi8>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %6 = tosa.matmul %0, %1, %4, %5 : (tensor<2x6x9xf32>, tensor<2x9x8xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<2x6x8xf32>
    %7 = tosa.const_shape  {values = dense<[3, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %8 = tosa.tile %6, %7 : (tensor<2x6x8xf32>, !tosa.shape<3>) -> tensor<6x12x8xf32>
    %9 = tosa.reduce_sum %8 {axis = 0 : i32} : (tensor<6x12x8xf32>) -> tensor<1x12x8xf32>
    %10 = tosa.bitwise_or %2, %3 : (tensor<7x6x2x7xi8>, tensor<7x6x1x1xi8>) -> tensor<7x6x2x7xi8>
    %11 = tosa.bitwise_and %10, %10 : (tensor<7x6x2x7xi8>, tensor<7x6x2x7xi8>) -> tensor<7x6x2x7xi8>
    %12 = tosa.bitwise_or %10, %11 : (tensor<7x6x2x7xi8>, tensor<7x6x2x7xi8>) -> tensor<7x6x2x7xi8>
    %13 = tosa.const_shape  {values = dense<[2, 42, 7, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %14 = tosa.reshape %11, %13 : (tensor<7x6x2x7xi8>, !tosa.shape<4>) -> tensor<2x42x7x1xi8>
    %cast = tensor.cast %9 : tensor<1x12x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %12 : tensor<7x6x2x7xi8> to tensor<*xi8>
    %cast_1 = tensor.cast %14 : tensor<2x42x7x1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}

