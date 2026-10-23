module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<7x9x6xi16>}> : () -> tensor<7x9x6xi16>
    %1 = "tosa.const"() <{values = dense<159> : tensor<7x6x1xi16>}> : () -> tensor<7x6x1xi16>
    %2 = "tosa.const"() <{values = dense<-166> : tensor<1x8xi32>}> : () -> tensor<1x8xi32>
    %3 = "tosa.const"() <{values = dense<87> : tensor<1x1xi32>}> : () -> tensor<1x1xi32>
    %4 = "tosa.const"() <{values = dense<-1.672600e+02> : tensor<4x8xf32>}> : () -> tensor<4x8xf32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %7 = tosa.matmul %0, %1, %5, %6 : (tensor<7x9x6xi16>, tensor<7x6x1xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<7x9x1xi16>
    %8 = tosa.intdiv %2, %3 : (tensor<1x8xi32>, tensor<1x1xi32>) -> tensor<1x8xi32>
    %9 = tosa.sigmoid %4 : (tensor<4x8xf32>) -> tensor<4x8xf32>
    %10 = tosa.sigmoid %9 : (tensor<4x8xf32>) -> tensor<4x8xf32>
    %cast = tensor.cast %7 : tensor<7x9x1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<1x8xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<4x8xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

