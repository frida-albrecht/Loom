module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.024000e+01> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = "tosa.const"() <{values = dense<-1.156100e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %2 = "tosa.const"() <{values = dense<-165> : tensor<10x7x10x4xi32>}> : () -> tensor<10x7x10x4xi32>
    %3 = "tosa.const"() <{values = dense<116> : tensor<1x1x10x1xi32>}> : () -> tensor<1x1x10x1xi32>
    %4 = tosa.add %0, %1 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %5 = tosa.floor %4 : (tensor<2xf32>) -> tensor<2xf32>
    %6 = tosa.reciprocal %5 : (tensor<2xf32>) -> tensor<2xf32>
    %7 = tosa.pow %6, %4 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %8 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %9 = tosa.tile %7, %8 : (tensor<2xf32>, !tosa.shape<1>) -> tensor<2xf32>
    %10 = tosa.sigmoid %9 : (tensor<2xf32>) -> tensor<2xf32>
    %11 = tosa.bitwise_or %2, %3 : (tensor<10x7x10x4xi32>, tensor<1x1x10x1xi32>) -> tensor<10x7x10x4xi32>
    %12 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %13 = tosa.transpose %11 {perms = array<i32: 0, 3, 1, 2>} : (tensor<10x7x10x4xi32>) -> tensor<10x4x7x10xi32>
    %cast = tensor.cast %10 : tensor<2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %13 : tensor<10x4x7x10xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

